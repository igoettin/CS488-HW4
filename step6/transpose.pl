###############
#transpose.pl
###############
#
#Perl script that transposes the two files ALL_AML_grow.train.norm.tmp and ALL_AML_grow.test.norm.tmp
#
#For ALL_AML_grow.train.norm.tmp, the generated transposed text file is called ALL_AML_gcol.train.tmp
#For ALL_AML_grow.test.norm.tmp, the generated transposed text file is called ALL_AML_gcl_test.tmp
#
sub transpose{
    my($input_filename,$output_filename) = @_;
    open(my $write_file, '>', $output_filename);
    open(my $read_file, '<', $input_filename);
    my $row = <$read_file>;
    my $num_fields = 0;
    #Count the number of fields in the first row
    foreach my $element (split(/[,\n]/,$row))
        {$num_fields++;}
    #Reset the file reader back to the starting position
    seek($read_file,0,0);
    #Go through each column in the text file and create the transposed row.
    for(my $current_field = 0; $current_field < $num_fields; $current_field++){
        my $transposed_row = "";
        #Split the fields by , and newline
        #Index and concatenate the field for the new transposed row.
        while($row = <$read_file>){
            my @fields = split(/[,\n]/,$row);
            $transposed_row .= $fields[$current_field] . ",";
        }
        #Remove comma from transposed row, concatenate a newline.
        $transposed_row = substr($transposed_row,0,-1);
        $transposed_row .= "\n";
        #Write the transposed row to the output file
        print $write_file $transposed_row;
        #Reset the file reader to capture the next transposed row 
        seek($read_file,0,0);
    }
    close($write_file);
    close($read_file);
}

transpose("ALL_AML_grow.train.norm.tmp","ALL_AML_gcol.train.tmp");
transpose("ALL_AML_grow.test.norm.tmp","ALL_AML_gcol.test.tmp");

