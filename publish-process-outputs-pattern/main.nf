process foo{
  publishDir './foo', mode: 'copy', pattern: "*.*[!bam,bai]"

  output:
  file "*.*"

  """
  touch test.bam
  touch test.bai
  touch test.txt
  """
}

process footwo{
  publishDir './footwo', mode: 'copy', pattern: "*_1_*"

  output:
  file "*.*"

  """
  touch test_1_sample.bam
  touch test_1_result.txt
  touch test_2_sample.bam
  """
}
