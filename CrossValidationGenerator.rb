# Author : Arvis Sulovari, PhD
# Last edited: Circa 2014

file_names = ""
proceed = ""

# Keep asking the user to enter either idk of the two complete .gb file names, until they are ready to proceed

while proceed != "y"
   puts
   puts "******************************************************************************"
   puts "*Enter the file name. Alternatively, just type <idk>"
   file_names = gets.chomp.to_s

   # Accept file names in the following two orders: "U20753.gb,U96639.gb" or "U96639.gb,U20753.gb"

   if file_names != "idk"

        # Save the two file names entered into an array and assign each one of them to file_1 and file_2, respectively
        file_array=Array.new
        file_names.split(/,/).each do |each_choice|
        file_array.push(each_choice)
        end

        file_1 = file_array[0]
        file_2 = file_array[1]
        puts  
        puts "*You chose the following files: #{file_1}. Do you want to proceed (y/n)?"
        proceed = gets.chomp.to_s

   # If the user types <idk> then tell them about the  files listed in their current directory
   elsif file_names == "idk"
        
        # grep whatever satisfies the following RegEx pattern
        gb_file_count = %x(ls -l | grep -Eo "[A-Z]*[a-z]*.raw" | wc -l).chomp.to_i
        
        if gb_file_count >= 1
          puts "*You entered <idk>. I found #{gb_file_count} raw genotype files in your directory:"
          gb_files = %x(ls -l | grep -Eo "[A-Z]*[a-z]*.raw").chomp.to_s
       
          n = 1
          while n <= gb_file_count
            gb_files.each do |file|
            puts "#{n}. #{file}"
            n += 1
            end
          end
        
        # Exit the program if there are no files found in the directory 
        else
          puts "Sorry, there are no raw PLINK files in your directory. Bye bye!"
          exit
        end

       # To make it easy for the user, let's ask him/her to enter the numbers corresponding to the list of .gb files reported above
       puts "*Please enter the corresponding two numbers for the files you want me to analyze, separated by commas:"
       option = gets.chomp.to_s

       file_array=Array.new

       option.split(/,/).each do |each_choice|
       file_array.push(each_choice)
       end

       file_1 = %x(ls -l | grep -m #{file_array[0]} -Eo "[A-Z]*[a-z]*.raw" | tail -n 1).chomp.to_s
       # file_2 = %x(ls -l | grep -m #{file_array[1]} -Eo "U.{5}.gb" | tail -n 1).chomp.to_s

       # Here is a fail-safe, just in case the user made the wrong choice with regard to  files that will be compared/analyzed
       puts
       puts "*You chose the following file: #{file_1}. Do you want to proceed (y/n)?"
       proceed = gets.chomp.to_s
   else
   end
end

puts "the end"
