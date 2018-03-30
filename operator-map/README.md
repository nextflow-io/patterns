# Map operator 

Basic usage of `map` operator. 

## Synopsis 

The `map` operator transforms the content of a channel applying of *mapping* function to every item emitted by a channel. 

For examaple: 

```
Channel
    .from( 1, 2, 3, 4, 5 )
    .map{ it * it }
    .printn()
```

Execute the above snippet using the command: 

```
nextflow run basic_map.nf 
```

## What's next

#### 1. Return the original value and the square

Modify the above script so that the mapping channel return the original value and the square. Then print both of them. 

<details>
 <summary>Solution</summary>

```
Channel
    .from( 1, 2, 3, 4, 5 )
    .map{ [it, it * it] }
    .println{ x, square -> "the square of $x is $square" }
```    
</details>