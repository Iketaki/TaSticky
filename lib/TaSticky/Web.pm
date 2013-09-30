package TaSticky::Web;

use strict;
use warnings;
use utf8;

use DateTime;
use Kossy;
use DBI;
use Teng;
use Teng::Schema::Loader;

use Config::Simple;

filter 'set_title' => sub {
    my $app = shift;
    sub {
        my ($self, $c)  = @_;
        $c->stash->{site_name} = __PACKAGE__;
        $app->($self,$c);
    }
};

sub date_to_str {
    my ($datetime) = @_;
    my $now = $datetime->strftime("%Y-%m-%d");

    return $now;
}

get '/' => sub {
    my ($self, $c)  = @_;

    my @tasks = get_all();

    #foreach my $task (@tasks) {
    #    my $dt = DateTime->now() - $task->deadline_date;
    #    $task->{deadline_str} = "" . $dt->days . "日";
    #    mylog($task->{deadline_date});
    #}

    $c->render('index.tx', {
        tasks => \@tasks,
        now => date_to_str(DateTime->now())
    });
};

# done tasks list
get '/history' => sub {
    my ($self, $c)  = @_;

    my @tasks = get_all();

    $c->render('index.tx', {
        tasks => \@tasks
    });
};


post '/' => sub {
    my ($self, $c)  = @_;

    my $result = $c->req->validator([
        'body' => {
            rule => [
                ['NOT_NULL', 'Empty Body']
            ]
        }
    ]);

    add_task($result->valid('body'));

    $c->redirect('/');
};

post '/edit/{id}' => sub {
    my ($self, $c)  = @_;

    my $result = $c->req->validator([
        'body' => {
            rule => [
                ['NOT_NULL', 'Empty Body']
            ]
        }
    ]);

    edit_task($c->args->{id}, $result->valid('body'));

    $c->redirect('/');
};

sub edit_task {
    my ($id, $body, $dbh) = @_;

    my $row = teng($dbh)->single('tasks', +{id => $id});
    $row->update(+{body => $body});
}

# Ajax Call Method
post '/api/pos/{id}' => sub {
    my ($self, $c)  = @_;

    my $x = $c->req->param('x');
    my $y = $c->req->param('y');

    set_position($c->args->{id}, $x, $y);

    $c->render_json({ success => 1 });
};

post '/api/edit/{id}' => sub {
    my ($self, $c)  = @_;

    my $result = $c->req->validator([
        'body' => {
            rule => [
                ['NOT_NULL', 'Empty Body']
            ]
        }
    ]);

    edit_task($c->args->{id}, $result->valid('body'));

    $c->render_json({ success => 1 });
};

post '/api/delete/{id}' => sub {
    my ($self, $c)  = @_;

    delete_task($c->args->{id});

    $c->render_json({ success => 1 });
};

sub set_position {
    my ($id, $x, $y, $dbh) = @_;

    my $row = teng($dbh)->single('tasks', +{id => $id});
    $row->update(+{x => $x, y => $y});
}

sub add_task {
    my ($body, $dbh) = @_;

    teng($dbh)->insert('tasks' => {
        'body' => $body,
        'is_done' => 0,
        'deadline_date' => \'NOW()',
        'x' => 10,
        'y' => 10,
        'size' => 10,
        'created_at' => \'NOW()',
        'updated_at' => \'NOW()'
    });
}

sub delete_task {
    my ($id, $dbh) = @_;

    my $row = teng($dbh)->single('tasks', +{id => $id});
    $row->delete();
}

sub get_all {
    my ($dbh) = @_;
    my @rows = teng($dbh)->search('tasks');
}

# Database Operation
sub dbh {
    my $config = Config::Simple->new('Config');
    my $dsn = $config->param('dsn');
    my $db_user = $config->param('db_user');
    my $db_password = $config->param('db_password');

    my $dbh = DBI->connect($dsn, $db_user, $db_password, {
        mysql_enable_utf8 => 1,
    });

    die $DBI::errstr unless defined $dbh;

    return $dbh;
}

sub teng {
    my $dbh = shift;
    $dbh = $dbh || dbh();

    Teng::Schema::Loader->load(
        'dbh' => $dbh,
        'namespace' => 'TaSticky::DB'
    );
}

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
