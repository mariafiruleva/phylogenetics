rule raxml:
    input: aln=rules.muscle.output.aln
    output: tree="raxml/{prefix}/{prefix}"
    conda: ""
    log: ""
    benchmark: ""
    params: tool='mrbayes', data='nt'
    shell: """
           modeltest-ng -d {parans.data} -i {input.aln} -T {params.tool} -o {output.tree}
           """
