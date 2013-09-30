package TaSticky::Utility;

# written by @shioshiota, thx!!
sub mylog {
    my @str = @_;
    my $logfile = ">> /Users/Shunta/Documents/DeNA/log.txt";

    open(LOG, $logfile);
    print(LOG join("\n", @_));
    print(LOG "\n");
    close(LOG);

    return 1;
}

1;
