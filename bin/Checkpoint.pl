#!/usr/bin/perl -w
=head1 #===============================================================================
#        USAGE: perl Parallel_Checkpoint.pl <Check_log_file> <Key_words>
#
#  DESCRIPTION: Check if parallel processes have all been done
#
#       INPUTS: <Check_log_file> :  Log file generated by analysis pipeline
#               <Key_word>       :  One or more key words to check in log file
#
#        NOTES: None
#       AUTHOR: Xiaolong Zhang, zhangxiaol1@sysucc.org.cn
# ORGANIZATION: Bioinformatics Center, Sun Yat-sen University Cancer Center
#      VERSION: 1.1
#      CREATED: 08/18/2017
#     REVISION: ---
#===============================================================================
=cut
use strict;
die `pod2text $0` unless @ARGV >= 2;
my $check_file = shift or die $!;
my $max_time = 172800; # 3 days
my $time = 0;
my $judge;
while (1<2){
	my $fileExist = -e "$check_file";
	if ($fileExist){
		my $goal = @ARGV;
		my $count = 0;
		for (@ARGV){
			$count ++ if `grep $_ $check_file`;
		}
		if ($count == $goal){
			$judge = "Yes";
			last;
		}
	}
	sleep(10);
	$time ++;
	if ($time > $max_time){
		$judge = "NO";
		last:
	}
}
`echo \"Check point: $judge\" >> $check_file`;

