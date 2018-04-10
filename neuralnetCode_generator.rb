#Author: Arvis Sulovari, PhD
#Last edited: Circa 2014

puts "enter the number of SNPxSNP interactions you want to explore:"
intx = gets.chomp.to_i

puts "enter name of the training dataset:"
trainingDS = gets.chomp.to_s

puts "3-way or 2-way?"
ans = gets.chomp.to_i

puts "enter name of the output file:"
output = gets.chomp.to_s

#%x(rm 3BY3_neuralnet_trainingCode.txt)
#%x(rm 2BY2_neuralnet_trainingCode.txt)

if ans == 3
	i=0
	while i <= intx
	j = i + 1
		while j > i && j <= intx
		k = j + 1
			while k > j && k <= intx

				File.open("#{output}", 'a') {
				|file| file.write("set.seed(0);  neuralnet (formula = PHENOTYPE~snp#{i}+snp#{j}+snp#{k}, data=#{trainingDS}, hidden =c(3,2), rep=1, stepmax = 1e+09, linear.output=FALSE); ")
				}
			
				k = k + 1
			end
		j = j + 1
		end
	i = i + 1
	end

else
	i=0
        while i <= intx
        j = i + 1
        while j > i && j <= intx

				File.open("#{output}", 'a') {
                                |file| file.write("set.seed(0);  neuralnet (formula = PHENOTYPE~snp#{i}+snp#{j}, data=#{trainingDS}, hidden =c(3,2), rep=1, stepmax = 1e+09, linear.output=FALSE); ")
                                }
			
                j = j + 1

                end
        i = i + 1
        end

end



#File.open('3BY3_neuralnet_trainingCode.txt').each do |line|
#	%x(R --vanilla -q -e "library(neuralnet); trainDS <- read.table(\"cv1_train.txt\", header=T); #{line}")
#end



##### R_trainErr = %x(R -q -e "dat = read.table(\"2BY2_neuralnet_trainingCode.txt\")")



















