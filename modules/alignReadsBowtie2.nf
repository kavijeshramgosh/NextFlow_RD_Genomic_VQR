process alignReadsBowtie2 {

    // Directives
    container 'biocontainers/bowtie2:v2.4.1_cv1'
    tag "$sample_id"

    // [sample_ID, [read1, read2]]
    input:
    tuple val(sample_id), path(reads)

    output:
    tuple val(sample_id), path("${sample_id}.bt.bam")

    script:
    """
    bowtie2 -x ${params.bowtie2_index_files} -1 ${reads[0]} -2 ${reads[1]} -S ${sample_id}.sam
    samtools view -b - |
    samtools addreplacerg -r "@RG\\tID:${sample_id}\\tSM:${sample_id}\\tPL:illumina" - > ${sample_id}.bam
    """
}