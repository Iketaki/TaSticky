KoSticky
========
Web上で、好きなように付箋を貼ることで頭のなかを整理できるタスク管理アプリです。

Setup & Usage
========
* carton install
* mysqlに **tasticky** というDBを作成
* mysql -u {DB_USER} -p {DB_PASS} < sql/schema.sql
* Config.dist を Config にリネームして編集
* plackup -r app.psgi
