#!/usr/bin/env nextflow

/*
 * Copyright (c) 2023, Seqera Labs.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

 /*
  * author Ben Sherman <bentshermann@gmail.com>
  */

params.n_groups = 10
params.queue_size = 2

process A {
    input:
    val(index)

    output:
    tuple val(index), path('output.txt')

    script:
    """
    sleep 1

    echo "subworkflow ${index}, process A was here" >> output.txt
    """
}

process B {
    input:
    tuple val(index), path('input.txt')

    output:
    tuple val(index), path('output.txt')

    script:
    """
    sleep 1

    cat input.txt >> output.txt
    echo "subworkflow ${index}, process B was here" >> output.txt
    """
}

process C {
    input:
    tuple val(index), path('input.txt')

    output:
    tuple val(index), path('output.txt')

    script:
    """
    sleep 1

    cat input.txt >> output.txt
    echo "subworkflow ${index}, process C was here" >> output.txt
    """
}

process D {
    input:
    tuple val(index), path('input_b.txt'), path('input_c.txt')

    output:
    tuple val(index), path('output.txt')

    script:
    """
    sleep 1

    cat input_b.txt >> output.txt
    cat input_c.txt >> output.txt
    echo "subworkflow ${index}, process D was here" >> output.txt
    """
}

workflow diamond {
    Channel.of(1..params.n_groups)
      | A
      | (B & C)
      | join
      | D
}

process diamond_merged {
    maxForks params.queue_size

    input:
    val(index)

    output:
    tuple val(index), path('d.txt')

    script:
    """
    sleep 1

    # process A
    echo "subworkflow ${index}, process A was here" >> a.txt

    # process B
    process_b() {
        cat a.txt >> b.txt
        echo "subworkflow ${index}, process B was here" >> b.txt
    }
    process_b &

    # process C
    process_c() {
        cat a.txt >> c.txt
        echo "subworkflow ${index}, process C was here" >> c.txt
    }
    process_c &

    wait

    # process D
    cat b.txt >> d.txt
    cat c.txt >> d.txt
    echo "subworkflow ${index}, process D was here" >> d.txt
    """
}

workflow {
    Channel.of(1..params.n_groups)
      | diamond_merged
}
