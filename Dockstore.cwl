class: Workflow
doc: "Testing: align sequences with bwa mem, then convert ot BAM"
cwlVersion: v1.0

inputs:
  - id: fastq
    type: File
    doc: "Sequence reads to be aligned."
  - id: reference
    type: File
    doc: "Reference index against which the reads will be aligned."
    secondaryFiles:
      - ".amb"
      - ".ann"
      - ".pac"
      - ".bwt"
      - ".sa"
  - id: output_filename
    type: string
  - id: threads
    type: int

outputs:
  - id: output
    type: File
    doc: "Alignments in BAM format"
    outputSource: samtoolsview/output

steps:
  - id: bwamem
    in:
      - { id: fastq1, source: "#fastq" }
      - { id: index, source: "#reference" }
      - { id: threads, source: "#threads" }
    out:
      - { id: output.sam }
    run: bwamem.cwl
  - id: samtoolsview
    in:
      - { id: input, source: "#bwamem/output.sam" }
      - { id: output_name, source: "#output_filename" }
    out:
      - { id: output }
    run: samtoolsview.cwl
