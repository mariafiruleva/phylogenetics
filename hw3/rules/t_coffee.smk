rule t_coffee:
    input: fasta=lambda wildcards: input_data[wildcards.prefix]
    output: aln="out/t_coffee/{prefix}.aln", dnd="out/t_coffee/{prefix}.dnd", html="out/t_coffee/{prefix}.html"
    conda: "../env.yaml"
    log: "logs/{prefix}/t_coffee.log"
    benchmark: "benchmarks/{prefix}/t_coffee.txt"
    shell: "t_coffee {input.fasta} -run_name={output.aln} &> {log}"