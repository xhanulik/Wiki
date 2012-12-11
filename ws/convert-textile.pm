#!/usr/bin/perl -w


use strict;
use warnings;

use File::Basename;

die "Needs input and output file names"
	unless $#ARGV ge 0;

my $input_file_name = $ARGV[0];

my $output_dir = "";
$output_dir = $ARGV[1]
    if ($#ARGV ge 1);
$output_dir .= "/"
    if (length $output_dir);

my $basename = basename($input_file_name,{});

sub get_outfile_basename  {
    my ($filename) = @_;
    my $out = $filename;

    $filename =~ s|^(.*)\/(.*)$|$1\%2F$2|;
    $filename =~ s|^(.*):(.*)$|$1\%3A$2|;
    if (open my $file, "<$filename")   {
        my @lines = <$file>;
        if ((scalar @lines) && ($lines[0] =~ m|^=\s([^=]+)\s=\s*$|))   {
            $out = "$1";
            $out =~ s|\s|-|g;
            $out =~ s|[!\/\*&]||g;
            # $out =~ s|#|%23|g;
            $out =~ s|:|%3A|g;
            $out =~ s|-+|-|g;
        }

        close($file);
        return $out;
    }
    return;
}

my $output_file_name = get_outfile_basename($input_file_name).".textile";
print "In '$input_file_name', Out '$output_file_name'\n";

open(MYINPUTFILE, "<$input_file_name");
open(MYOUTPUTFILE, ">$output_dir$output_file_name");

my $prev_line = "";
my $num = 0;
while(<MYINPUTFILE>)   {
    my($line) = $_;
    my $line_orig = $line;

    next
        if ($line =~ m|^\[\[TOC\]\]\s*$|);

    print MYOUTPUTFILE "\n"
	    if (($line =~ m|^[=]+\s\S|) and (length($prev_line) gt 1));

    $line =~ s|==== (.*) ====|h4. $1|g;
    $line =~ s|=== (.*) ===|h3. $1|g;
    $line =~ s|== (.*) ==|h2. $1|g;
    $line =~ s|= (.*) =|h1. $1|g;
    $line =~ s|!#|#|g;

    print MYOUTPUTFILE "\n"
	    if (($prev_line =~ m|^h[1-9].\s+\S|) and ($line =~ m|\w|));

    $line =~ s|\s!(\w+)| $1|g;

    # [http://www.ietf.org/rfc/rfc2119.txt RFC2119]
    # [RFC2119](http://www.ietf.org/rfc/rfc2119.txt)
    if ($line =~ m|\[(https?://\S+)\s([^\]]*)\]|)   {
        $line =~ s|\[(https?://\S+)\s([^\]]*)\]|\"$2\":$1|g;
    }
    elsif ($line =~ m|\[(https?://\S+)\s*\]|)   {
        $line =~ s|\[(https?://\S+)\s*\]|\"$1\":$1|g;
    }
    $line =~ s|(\s+)(https?://\S+)|$1\"$2\":$2|g;
    $line =~ s|^(https?://\S+)|\"$1\":$1|g;
    $line =~ s|\{\{\{([^\}]+)\}\}\}|_$1_|g;
    if ($line =~ m|\{\{\{|)   {
        $line =~ s|\{\{\{|<pre><code>|g;
        $line =~ s/[\r\n]//g;
        my $next_line = <MYINPUTFILE>;
        $next_line =~ s/[\r]//g;
        print MYOUTPUTFILE $line.$next_line;
        while(<MYINPUTFILE>)   {
            my($code_line) = $_;
            $code_line =~ s/[\r]//g;
            if ($code_line =~ m|\}\}\}|)   {
               $code_line =~ s|\}\}\}|</code></pre>|g;
               print MYOUTPUTFILE $code_line;
               last;
            }
            else   {
               print MYOUTPUTFILE $code_line;
            }
        }
        next;
    }
    # $line =~ s|\}\}\}|</code></pre>|g;
    $line =~ s|'''([^\']*)'''|<b>$1</b>|g;
    $line =~ s|''([^\']*)''|<i>$1</i>|g;

    # [[Image(OpenSC_code_flow.png)]]
    # ![OpenSC code flow](attachments/DevelopmentPolicy/OpenSC_code_flow.png)
    $line =~ s|\[\[Image\(([^\)]+)\)\]\]|\!attachments\/wiki\/$input_file_name\/$1\($input_file_name\)\!|;

    #[wiki:engine_pkcs11 engine_pkcs11]
    #[Testing](Test)

    if ($line =~ m|\[wiki:(\S+)\s+([^\]]*)\]|)   {
        my $basename = get_outfile_basename($1);
        if (defined $basename)   {
            $basename =~ s|#|%23|g;
            $line =~ s|\[wiki:(\S+)\s+([^\]]*)\]|\"$2\":wiki/$basename|;
        }
        else   {
            $line =~ s|\[wiki:(\S+)\s+([^\]]*)\]|"Not found: text($2) link($1)":wiki/$1|;
        }
    }

    map   {
        my $expand_name = $_;
        if ($line =~ m|<b>($expand_name)</b>|)   {
            my $basename = get_outfile_basename($1);
            if (defined $basename)   {
                $basename =~ s|#|%23|g;
                $line =~ s|<b>($expand_name)</b>|\"<b>$1</b>\":wiki/$basename|;
            }
        }
        elsif ($line =~ m|($expand_name)|)   {
            my $basename = get_outfile_basename($1);
            if (defined $basename)   {
                $basename =~ s|#|%23|g;
                $line =~ s|($expand_name)|\"$1\":wiki/$basename|;
            }
        }
    } ("GetStarted", "SupportedHardware", "GetInvolved", "DeveloperInformation",
            "FrequentlyAskedQuestions", "SecurityAdvisories", "DownloadRelease", 
            "CommercialOffer", "NightlyBuilds", "OpenSC 0.12.2", "OpenSC 0.13.0");

    if ($line =~ m|\[wiki:(\S+)\s*\]\w|)   {
        my $basename = get_outfile_basename($1);
        if (defined $basename)   {
            $basename =~ s|#|%23|g;
            $line =~ s|\[wiki:(\S+)\s*\](\w*)|\"$basename\":wiki/$basename\n$2|;
        }
        else   {
            $line =~ s|\[wiki:(\S+)\s*\]|"Not found: link($1)":wiki/$1|;
        }
    }

    if ($line =~ m|\[wiki:(\S+)\s*\]|)   {
        my $basename = get_outfile_basename($1);
        if (defined $basename)   {
            $basename =~ s|#|%23|g;
            $line =~ s|\[wiki:(\S+)\s*\]|\"$basename\":wiki/$basename|;
        }
        else   {
            $line =~ s|\[wiki:(\S+)\s*\]|"Not found: link($1)":wiki/$1|;
        }
    }

    $line =~ s/\|\|/\|/g
	if ($line =~ m/^\|\|(.*)\|\|\s*$/);


    $line =~ s/\r//g;
    $prev_line = $line;
    print MYOUTPUTFILE "$line";
}

print MYOUTPUTFILE "\n";

close(MYINPUTFILE);
close(MYOUTPUTFILE);


