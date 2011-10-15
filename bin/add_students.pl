#!/usr/bin/perl

use strict;
use warnings;
use feature qw/say/;
use Getopt::Long;
use Passwd::Unix;
use String::Random;


sub create_student {
	my $stu = shift;

	# check stu isn't in the passwd file
	my $stumatch = `grep $stu /etc/passwd`; chomp($stumatch);
	if ($stumatch) {
		say 'FAILED - too similar to another username';
		return;
	}

	# generate a new port number which hasn't been used in a username
	my $port;
	foreach my $i (1..1000) {
		$port = int(rand(999)) + 3001;
		my $portmatch = `grep $port /etc/passwd`; chomp($portmatch);

		unless ($portmatch) {
			last;
		}
		if ($i eq 1000) {
			say 'FAILED - to find an unused port';
			return;
		}
	}


	# Create the user
	
	if (system("useradd -m $stu")) {
		say 'FAILED - to add user';
		return;
	}

	# Set the password
	my $rand = new String::Random;
	my $prefix = $rand->randpattern("ccc");
	my $pu = Passwd::Unix->new();
	$pu->passwd($stu, $pu->encpass("${prefix}$port"));

	# store this port number in the student's .bashrc as DANCER_PORT
	if (system("echo export DANCER_PORT=$port >> /home/$stu/.bashrc")) {
		say 'FAILED - to set DANCER_PORT userdel -r <username> and try again';
	}
	if (system(q{echo export PS1=\'\\\u@[lpw.illywhacker.net:\$DANCER_PORT] \\\w \\\$ \\\n\' >> /home/}.$stu.'/.bashrc')) {
		say 'FAILED - to set prompt -  userdel -r <username> and try again';
	}

	say "Created $stu - password: ${prefix}$port";
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
	Create a student called 'barry'

	$0 --student barry

	prints the username and a password (ending with their HTTP port number)

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



