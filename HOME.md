# Swan Command Center

---

## Needs Attention

```dataview
LIST WITHOUT ID file.name
FROM "03-Sessions/Managed-Agents"
WHERE contains(file.content, "Blocked") OR contains(file.content, "Needs Input")
SORT file.name DESC
LIMIT 10
```

---

## Recent Agent Sessions

```dataview
TABLE WITHOUT ID file.name AS "Session", file.mtime AS "Modified"
FROM "03-Sessions/Managed-Agents"
SORT file.mtime DESC
LIMIT 10
```

---

## Daily Notes

```dataview
TABLE WITHOUT ID file.name AS "Date" FROM "04-Daily" WHERE file.name != ".gitkeep" SORT file.name DESC LIMIT 7
```
