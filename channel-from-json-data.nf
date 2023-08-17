#!/usr/bin/env nextflow

nextflow.enable.dsl=2

import groovy.json.JsonSlurper

process echo_name {
    input:
        val sample
    output:
        stdout emit: verbiage
    shell:
        '''
        echo -n "!{sample.name}"
        '''
}

workflow {
    main:
        def json_text = '{"samples": [{"id": 1, "name": "A"}, {"id": 2, "name": "B"}, {"id": 3, "name": "C"}]}'
        def input_json = new JsonSlurper().parseText(json_text)

        echo_name(Channel.from(input_json.samples))
        echo_name.out.verbiage.view()
}