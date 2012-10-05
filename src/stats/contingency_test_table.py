import sys
import re
import string

if len(sys.argv) != 2:
    print "Usage: python contingency_test_table.py <results_file>"
    sys.exit()
else:
    input_filename = sys.argv[1]

lang_keys = ['c', 'cpp', 'cs', 'hs', 'java', 'js', 'php', 'pl', 'py', 'rb']
lang_len = len(lang_keys)
lang_order = {}

for cat_index, cat_key in enumerate(lang_keys):
    lang_order[cat_key] = cat_index
    
f = open(input_filename)
test_names = []
tests = []
current_test_index = -1
re_pattern = re.compile("^.+for (.+) and (.+),.+$")

for line in f:
    if line.startswith("TEST:"):
        test_names.append(line.split()[1])
        current_test_index += 1
        init_test_results = [[False for i in range(lang_len)]
                             for i in range(lang_len)]
        tests.append(init_test_results)
    elif line.find("null hypothesis not rejected") != -1:
        m = re_pattern.match(line)
        row = m.group(1)
        col = m.group(2)
        row_index = lang_order[row]
        col_index = lang_order[col]
        tests[current_test_index][row_index][col_index] = True

latex_keys = ['C', 'C++', 'C\#', 'Haskell', 'Java', 'Javascript',
              '{\sc php}', 'Perl', 'Python', 'Ruby']

latex_cells = [["" for i in range(lang_len)] for i in range(lang_len)]

num_tests = current_test_index + 1
for i in range(lang_len):
    for j in range(lang_len):
        if i >= j:
            latex_cells[i][j] = latex_cells[j][i]
        else:
            format_str = "{}" * num_tests
            format_str = r'$\scriptscriptstyle' + format_str +'$'
            values = []
            for test_index, test in enumerate(tests):
                # bkarak's addition #
                if test_index in [1,5,9,13,17]:
                    values.append('' + sep)
                    continue
                # end bkarak #
                if test_index != num_tests - 1 and test_index % 4 == 3:
                    sep = '|'
                else:
                    sep = ''
                if test[i][j] == True:
                    values.append(r'\blacklozenge' + sep)
                else:
                    values.append(r'\lozenge' + sep)
            cell_value = format_str.format(*values)
            latex_cells[i][j] = cell_value

for lang_index, lang in enumerate(latex_keys):
    print """
\subtable[%s]{
\\begin{tabular}{l c}
$\scriptscriptstyle IdSub|IntPer|CharSub|TokSub|SimSub$\\\\
\\hline
""" % lang
    for i in range(lang_len):
        if i != lang_index:
            print latex_keys[i], "&", latex_cells[i][lang_index], "\\\\"
        
    print """
\\hline
& \\\\
\\end{tabular}
}""",
