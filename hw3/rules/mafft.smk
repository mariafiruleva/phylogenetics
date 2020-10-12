rule mafft:
    input: fasta=lambda wildcards: input_data[wildcards.prefix]
    output: aln="out/mafft/{prefix}.fa"
    conda: "../env.yaml"
    log: "logs/{prefix}/mafft.log"
    benchmark: "benchmarks/{prefix}/mafft.txt"
    shell: "mafft {input.fasta} > {output.aln} 2> {log}"