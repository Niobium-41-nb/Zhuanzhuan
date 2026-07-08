#!/usr/bin/env python3
"""修复 DOCX 中表格问题：移除空表格和多余空列"""

from docx import Document
from docx.oxml.ns import qn

DOCX_PATH = r'E:\Zhuanzhuan\docs\实训报告\综合实训报告.docx'

doc = Document(DOCX_PATH)
body = doc.element.body

# 1. 移除所有空表格（0行）
tables = body.findall(qn('w:tbl'))
removed = 0
for tbl in tables:
    rows = tbl.findall(qn('w:tr'))
    if len(rows) == 0:
        body.remove(tbl)
        removed += 1
        print('移除空表格')

print(f'共移除 {removed} 个空表格')

# 2. 修复多余空列
tables = body.findall(qn('w:tbl'))
for ti, tbl in enumerate(tables):
    rows = tbl.findall(qn('w:tr'))
    if len(rows) == 0:
        continue

    first_row = rows[0]
    cells = first_row.findall(qn('w:tc'))

    if len(cells) >= 4:
        last_col_empty = True
        for row in rows:
            row_cells = row.findall(qn('w:tc'))
            if len(row_cells) >= 4:
                last = row_cells[3]
                text_parts = []
                for p in last.findall(qn('w:p')):
                    for r in p.findall(qn('w:r')):
                        t = r.find(qn('w:t'))
                        if t is not None and t.text:
                            text_parts.append(t.text)
                if ''.join(text_parts).strip():
                    last_col_empty = False
                    break

        if last_col_empty:
            print(f'表{ti+1}: 移除多余空列')
            for row in rows:
                row_cells = row.findall(qn('w:tc'))
                if len(row_cells) >= 4:
                    row.remove(row_cells[3])
            tblGrid = tbl.find(qn('w:tblGrid'))
            if tblGrid is not None:
                gridCols = tblGrid.findall(qn('w:gridCol'))
                if len(gridCols) >= 4:
                    tblGrid.remove(gridCols[3])

doc.save(DOCX_PATH)
print(f'\n修复完成: {DOCX_PATH}')
