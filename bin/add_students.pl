#!/usr/bin/perl

use strict;
use warnings;
use feature qw/say/;
use Getopt::Long;
use Passwd::Unix;


sub create_student {
	my $stu = shift;
	print "creating student $stu ... ";

	# check stu isn't in the passwd file
	my $stumatch = `grep $stu /etc/passwd`; chomp($stumatch);
	if ($stumatch) {
		say 'FAILED - too similar to another username';
		return;
	}

	# generate a new port number which hasn't been used in a username
	my $port;
	foreach my $i (1..1000) {
		print '-';
		$port = int(rand(999)) + 3001;
		my $portmatch = `grep $port /etc/passwd`; chomp($portmatch);

		unless ($portmatch) {
			print " port number $port  ... ";
			last;
		}
		if ($i eq 1000) {
			say 'FAILED - to find an unused port';
			return;
		}
	}

	my $username = "${stu}.$port";

	# Create the user

	# Set the password

	# store this port number in the student's .bashrc as DANCER_PORT
	say " $username Succeeded";
}

my ($filename,$student, $help);

my $result = GetOptions (
	"filename=s" => \$filename,
	"student=s" => \$student,
	"help" => \$help,
);

sub helpmsg {
	say <<__END__ ; 

Synopsis 
	Create a student called 'barry.<portnum>'

	$0 --student barry

	prints the username containing the portnumber and a password 

	Create a set of students from a file consisting of a username per line

	$0 --filename <somefile>

	prints a line as above for each username.

__END__

}

if ($student) {
	create_student($student);
}
elsif ($filename) {

	open(USERNAMES, "<$filename");
	my(@lines) = <USERNAMES>; 

	foreach my $line (@lines) {
		chomp($line);
		next unless $line =~ /^\w+$/;
		create_student($line);
	}

} 
else {
	helpmsg();
}



