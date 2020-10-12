import re

rule clustalw:
    input: fasta=lambda wildcards: input_data[wildcards.prefix]
    output: aln="out/clustalw/{prefix}.aln", dnd="out/clustalw/{prefix}.dnd"
    conda: "../env.yaml"
    log: "logs/{prefix}/clustalw.log"
    benchmark: "benchmarks/{prefix}/clustalw.txt"
    params: in_dir=lambda wildcards, input: re.sub('/.*', '', input.fasta), prefix=lambda wildcards: f'{wildcards.prefix}'
    shell:
        """
        clustalw2 {input.fasta} &> {log}
        mv {params.in_dir}/{params.prefix}.aln {output.aln}
        mv {params.in_dir}/{params.prefix}.dnd {output.dnd}
        """