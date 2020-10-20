rule raxml_basic_tree:
    input: aln=rules.muscle.output.aln
    output: tree="raxml/{prefix}/{prefix}.raxml.bestTree"
    conda: "../env.yaml"
    log: "logs/{prefix}/raxml_basic_tree.log"
    benchmark: "benchmarks/{prefix}/raxml_basic_tree.txt"
    params: model='GTR+I+G4', outgroup=lambda wildcards: outgroups[wildcards.prefix],
            out_prefix=lambda wildcards: f'raxml/{wildcards.prefix}/{wildcards.prefix}'
    shell: """
           raxml-ng --msa {input.aln} --model {params.model} --prefix {params.out_prefix} --outgroup {params.outgroup}
           """


rule raxml_bootstrap:
    input: aln=rules.muscle.output.aln
    output: tree="raxml/{prefix}/{prefix}.raxml.bootstraps"
    conda: "../env.yaml"
    log: "logs/{prefix}/raxml_bootstrap.log"
    benchmark: "benchmarks/{prefix}/raxml_bootstrap.txt"
    params: model='GTR+I+G4', seed=42, boot_n=100, outgroup=lambda wildcards: outgroups[wildcards.prefix],
            out_prefix=lambda wildcards: f'raxml/{wildcards.prefix}/{wildcards.prefix}'
    shell: """
           raxml-ng --bootstrap --msa {input.aln} --model {params.model} --prefix {params.out_prefix} \
           --outgroup {params.outgroup} --seed {params.seed} --bs-trees {params.boot_n}
           """

rule raxml_extract_tree:
    input: tree=rules.raxml_basic_tree.output.tree, boot=rules.raxml_bootstrap.output.tree
    output: tree="raxml/{prefix}/{prefix}_supported.raxml.support"
    conda: "../env.yaml"
    log: "logs/{prefix}/raxml_extract_tree.log"
    benchmark: "benchmarks/{prefix}/raxml_extract_tree.txt"
    params: model='GTR+I+G4', seed=42, boot_n=100, outgroup=lambda wildcards: outgroups[wildcards.prefix],
            out_prefix=lambda wildcards: f'raxml/{wildcards.prefix}/{wildcards.prefix}_supported'
    shell: """
           raxml-ng --support --tree {input.tree} --bs-trees {input.boot} --prefix {params.out_prefix} \
           --seed {params.seed} --outgroup {params.outgroup}
           """
