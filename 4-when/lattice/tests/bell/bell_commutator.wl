; bell commutator — programming syntax
; commutator of basis quaternions i and j

quat i = [0, 1, 0, 0]
quat j = [0, 0, 1, 0]
quat ij = qmul(i, j)
quat ji = qmul(j, i)
quat comm = qsub(ij, ji)
return comm[3]
