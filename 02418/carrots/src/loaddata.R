carrots = read.table("../data/carrots.txt", header=TRUE, sep=",")
carrots$Consumer = factor(carrots$Consumer)
carrots$Age = factor(carrots$Age)
carrots$Gender = factor(carrots$Gender)
carrots$product = factor(carrots$product)

