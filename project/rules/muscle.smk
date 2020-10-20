rule muscle:
    input: fasta=lambda wildcards: input_data[wildcards.prefix]
    output: aln="out/muscle/{prefix}.fa"
    conda: "../env.yaml"
    log: "logs/{prefix}/muscle.log"
    benchmark: "benchmarks/{prefix}/muscle.txt"
    shell: "muscle -in {input.fasta} -out {output.aln} &> {log}"