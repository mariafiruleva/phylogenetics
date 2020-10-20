rule prank:
    input: fasta=lambda wildcards: input_data[wildcards.prefix]
    output: aln="out/prank/{prefix}.best.fas"
    conda: "../env.yaml"
    log: "logs/{prefix}/prank.log"
    benchmark: "benchmarks/{prefix}/prank.txt"
    params: out_prefix=lambda wildcards: f'out/prank/{wildcards.prefix}'
    shell: "prank -d={input.fasta} -o={params.out_prefix} &> {log}"