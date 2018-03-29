# Hello-world 

Classic Hello world example. 

## Synopsis 

This example shows how to write a basic task to execute a user command 
in a parallel manner. 

To execute it use the following command: 

```
nextflow run hello-world.nf
```

It executes four times the command `echo` with a different word taken from the `cheers` channel.

Note also how the `stdout` is captured and redirected into the `result` channel. 

Finally the content of the `result` channel it printed using the `println` operator.


## What's next

#### 1. Check the work directory
 
Nextflow executes each task in a separate working directory. Verify that using this command: 

```
tree -a work 
```

You will see that a separate directory was created to execute each task.

```
$ tree -a work/
work/
├── 84
│   └── c2a0247278784ef9b32f401f477275
│       ├── .command.begin
│       ├── .command.err
│       ├── .command.log
│       ├── .command.out
│       ├── .command.run
│       ├── .command.sh
│       └── .exitcode
├── 90
│   └── 9e155c1fa5f10c6b4d9a7de1a91786
│       ├── .command.begin
│       ├── .command.err
│       ├── .command.log
│       ├── .command.out
│       ├── .command.run
│       ├── .command.sh
│       └── .exitcode
├── 98
│   └── 75ac808ab41baf85b4c1eb73ffbc87
│       ├── .command.begin
│       ├── .command.err
│       ├── .command.log
│       ├── .command.out
│       ├── .command.run
│       ├── .command.sh
│       └── .exitcode
└── e1
    └── 1b8bbcd7c0e9f7dee208239f343aee
        ├── .command.begin
        ├── .command.err
        ├── .command.log
        ├── .command.out
        ├── .command.run
        ├── .command.sh
        └── .exitcode
```         

The name of these directories correspond to the unique ID assigned to each task executions whose prefix is printed in the execution log (the hex number in square bracktes)

#### 2. Task multiplicity 

The `printHello` process is excuted as many times as the number of words emitted by the `cheers` channel. 

Try to add or remove a word and see how it changes. 


