## Problem 

You have channels you want to combine, but the elements in these channels are related and you want this new combined channel to take this into consideration. Some Nextflow channel operators can combine elements in channels according to a matching key but, unfortunately, in your case you have no such key.

## Solution

Use the [map](https://www.nextflow.io/docs/latest/operator.html#map) operator and the `toString` and `split` native Groovy functions to extract a matching key from every element of your channel. Then, use the [combine](https://www.nextflow.io/docs/latest/operator.html#combine) operator to combine the channels according to the created matching key.

The code below will create sample channels to test the solution.

```groovy
Channel
  .of('demux.Clontech_5p--bc1003_3p.flnc_clustered.sorted.sam',
      'demux.Clontech_5p--bc1001_3p.flnc_clustered.sorted.sam',
      'demux.Clontech_5p--bc1002_3p.flnc_clustered.sorted.sam')
  .set { ch_alignment }

Channel
  .of('demux.Clontech_5p--bc1001_3p.flnc_clustered.fasta',
      'demux.Clontech_5p--bc1002_3p.flnc_clustered.fasta',
      'demux.Clontech_5p--bc1003_3p.flnc_clustered.fasta')
  .set { ch_clustered }
```
## Code

```groovy
ch_alignment
  // For every element of this channel, convert it to a string, split in pieces separated by --, get the second part, then split by _3p and get the first part. Return a list with this as the first value, and then the original element as the second value. This part has to be customized depending on what part of the String you want to get as matching key
  .map { [it.toString().split("--")[1].split("_3p")[0],
          it] }.
  set { ch_alignment }
ch_clustered
  .map { [it.toString().split("--")[1].split("_3p")[0],
          it] }.
  set { ch_clustered }

ch_alignment
  // Combine according to a key that is the first value of every first element, which is a list according to what we did above
  .combine(ch_clustered, by: 0)
  // For every element of this channel, which consists of three values now, the matching key (id), the first element of the first channel, and the second, keep only the second and the third.
  .map { id, sam, fasta -> [sam, fasta] }
  // View the content of the channel, which consists of the last two values
  .view()
```

## Run it

Run the example using this command:

```bash
nextflow run nextflow-io/patterns/create-key-to-combine-channels.nf
```
