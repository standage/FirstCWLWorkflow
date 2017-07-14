class: CommandLineTool
doc: BwaMem
id: bwa-mem-0.7.15
label: "bwa mem v0.7.5"

cwlVersion: v1.0

dct:creator:
  "@id": "http://orcid.org/0000-0003-0342-8531"
  foaf:name: Daniel Standage
  foaf:mbox: "mailto:daniel.standage@gmail.com"

requirements:
  - class: DockerRequirement
    dockerPull: "biocontainers/bwa:0.7.15"

hints:
  - class: ResourceRequirement
    coresMin: 4
    ramMin: 2000

inputs:
  short_split_flag:
    type: boolean
    default: true
    doc: "mark shorter split hits as secondary"
    inputBinding:
      position: 1
      prefix: -M
  threads:
    type: int
    doc: "number of threads"
    inputBinding:
      position: 2
      prefix: -t
  index:
    type: File
    doc: "reference index"
    inputBinding:
      position: 3
    secondaryFiles:
      - ".amb"
      - ".ann"
      - ".pac"
      - ".bwt"
      - ".sa"
  fastq1:
    type: File
    doc: "fastq"
    inputBinding:
      position: 4
  fastq2:
    type: File?
    doc: "optional second fastq file"
    inputBinding:
      position: 5

outputs:
  output.sam:
    type: File
    doc: "Alignments in SAM format"
    outputBinding:
      glob: output.sam

stdout: output.sam

baseCommand: ["bwa", "mem"]
