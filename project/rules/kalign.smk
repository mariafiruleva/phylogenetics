rule kalign:
    input: fasta=lambda wildcards: input_data[wildcards.prefix]
    output: aln="out/kalign/{prefix}.fa"
    conda: "../env.yaml"
    log: "logs/{prefix}/kalign.log"
    benchmark: "benchmarks/{prefix}/kalign.txt"
    shell: "kalign {input.fasta} {output.aln} &> {log}"