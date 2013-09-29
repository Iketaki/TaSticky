USE tasticky;

CREATE TABLE IF NOT EXISTS tasks(
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  parent_id INTEGER,
  body TEXT NOT NULL,
  is_done BOOLEAN NOT NULL,
  deadline_date DATETIME,
  x INTEGER,
  y INTEGER,
  size INTEGER,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL
);
