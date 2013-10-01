package TaSticky::Utility;

# written by @shioshiota, thx!!
sub mylog {
    my $self = shift;
    my @str = @_;
    my $logfile = ">> log/mylog.txt";

    open(LOG, $logfile);
    print(LOG join("\n", @_));
    print(LOG "\n");
    close(LOG);

    return 1;
}

1;
