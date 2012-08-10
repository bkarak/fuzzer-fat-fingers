import data_structures, task_code_stats

class LineVisitor(object):
	def __init__(self):
		super(LineVisitor, self).__init__()
		self.langs_export = ['c', 'cpp', 'cs', 'hs', 'java', 'js', 'php', 'pl', 'py', 'rb']
		self.lang_names = {'c' : 'C', 'cpp' : 'C++', 'cs' : 'C\\#', 
						   'hs' : 'Haskell', 'java' : 'Java', 'js' : 'Javascript',
						   'php' : 'PHP', 'pl' : 'Perl', 'py' : 'Python', 'rb' : 'Ruby'}

	def visit(self, task_name, language, fuzzer_name, activity, result):
		pass

	def export(self):
		pass

class TaskAggregator(LineVisitor):
	def __init__(self):
		super(TaskAggregator, self).__init__()
		self.__tasks = {}

	def visit(self, task_name, language, fuzzer_name, activity, result):
		if fuzzer_name == 'prime':
			pass

		if language == 'm':
			# objective-c
			pass

		# results are task_name, (lang, no_compiled_success, no_run_success, no_fuz, no_output_success)
		results = self.__tasks.get(task_name, {})
		stat_structure = results.get(language, data_structures.StatStructure(language))
		stat_structure.update(activity, result)
		results[language] = stat_structure
		self.__tasks[task_name] = results

	def __export(self, languages):
		for (tn, struct_dict) in self.__tasks.iteritems():
			print "%s & " % (tn,),
			for lang in languages:
				ss = struct_dict[lang]
				print r"%d & %d & %d &" % (ss.rate_compiled()*100, ss.rate_run()*100, ss.rate_output()*100),
			print "\\\\"		

	def export(self):
		print 'Export TaskAggregator'
		self.__export(self.langs_export[:5])
		print "--------"
		self.__export(self.langs_export[5:])


class AggregatedTasks(LineVisitor):
	def __init__(self):
		super(AggregatedTasks, self).__init__()
		self.__languages = {}
		self.fuzzers = []

	def visit(self, task_name, language, fuzzer_name, activity, result):
		if language == 'm':
			pass

		if fuzzer_name not in self.fuzzers:
			self.fuzzers.append(fuzzer_name)

		results = self.__languages.get(language, {})
		fuzzer_dict = results.get(fuzzer_name, data_structures.StatStructure(fuzzer_name))
		fuzzer_dict.update(activity, result)
		results[fuzzer_name] = fuzzer_dict
		self.__languages[language] = results
		
	def export(self):
		print 'Export AggregatedTasks'
		print self.fuzzers
		_dict_fz = data_structures.DictCount()

		for l in self.langs_export:
			print "%s &" % (self.lang_names[l]),
			results = self.__languages[l]

			for fz in self.fuzzers:
				fd = results[fz]

				if fz == 'prime' or fz == 'original':
					continue

				print "%.1f & %.1f & %.1f" % (fd.rate_compiled()*100, fd.rate_run()*100, fd.rate_output()*100),
				
				# last line
				_dict_fz.add("%s.com"%fz, val=fd.succ_compiled)
				_dict_fz.add("%s.run"%fz, val=fd.succ_run)
				_dict_fz.add("%s.out"%fz, val=fd.succ_output)
				_dict_fz.add("%s.fuzz"%fz, val=fd.succ_fuzz)

				# total for all fuzzers
				_dict_fz.add("%s.total_com"%l, val=fd.succ_compiled)
				_dict_fz.add("%s.total_run"%l, val=fd.succ_run)
				_dict_fz.add("%s.total_out"%l, val=fd.fail_output)
				_dict_fz.add("%s.total_succ_out"%l, val=fd.succ_output)
				_dict_fz.add("%s.total_fuzz"%l, val=fd.succ_fuzz)

				if fz != self.fuzzers[len(self.fuzzers) - 1]:
					print " &",

			print "\\\\"

		print "Total &",
		for fz in self.fuzzers:
			if fz == 'prime' or fz == 'original':
				continue
			_com_rate = float(_dict_fz.get_value("%s.com"%fz)) / float(_dict_fz.get_value("%s.fuzz"%fz))
			_run_rate = float(_dict_fz.get_value("%s.run"%fz)) / float(_dict_fz.get_value("%s.fuzz"%fz))
			_out_rate = float(_dict_fz.get_value("%s.out"%fz)) / float(_dict_fz.get_value("%s.fuzz"%fz))
			print "\\textbf{%.1f} & \\textbf{%.1f} & \\textbf{%.1f}" % (100*_com_rate, 100*_run_rate, 100*_out_rate),

			if fz != self.fuzzers[len(self.fuzzers) - 1]:
				print " &",

		print "\\\\"
		print "---- summary"

		for l in self.langs_export:
			_total_rate_com = float(_dict_fz.get_value("%s.total_com"%l) - _dict_fz.get_value("%s.total_succ_out"%l)) / float(_dict_fz.get_value("%s.total_fuzz"%l))
			_total_rate_run = float(_dict_fz.get_value("%s.total_run"%l) - _dict_fz.get_value("%s.total_succ_out"%l)) / float(_dict_fz.get_value("%s.total_fuzz"%l))
			_total_rate_out = float(_dict_fz.get_value("%s.total_out"%l)) / float(_dict_fz.get_value("%s.total_fuzz"%l))

			_dict_fz.add("grand_total_com", val=_dict_fz.get_value("%s.total_com"%l))
			_dict_fz.add("grand_total_run", val=_dict_fz.get_value("%s.total_run"%l))
			_dict_fz.add("grand_total_out", val=_dict_fz.get_value("%s.total_out"%l))
			_dict_fz.add("grand_total_succ_out", val=_dict_fz.get_value("%s.total_succ_out"%l))
			_dict_fz.add("grand_total_fuzz", val=_dict_fz.get_value("%s.total_fuzz"%l))

			print "%s & %.1f & %.1f & %.1f\\\\" % (self.lang_names[l], 100*_total_rate_com, 100*_total_rate_run, 100*_total_rate_out)

		_grand_total_succ_out = _dict_fz.get_value("grand_total_succ_out")

		print "run: %d" % _dict_fz.get_value("grand_total_run")
		print "succ_out: %d" % _grand_total_succ_out
		print "out: %d" % _dict_fz.get_value("grand_total_out")
		_grand_total_com_rate = float(_dict_fz.get_value("grand_total_com") - _grand_total_succ_out) / float(_dict_fz.get_value("grand_total_fuzz"))
		_grand_total_run_rate = float(_dict_fz.get_value("grand_total_run") - _grand_total_succ_out) / float(_dict_fz.get_value("grand_total_fuzz"))
		_grand_total_out_rate = float(_dict_fz.get_value("grand_total_out")) / float(_dict_fz.get_value("grand_total_fuzz"))

		print "\\textbf{Mean} & \\textbf{%.1f} & \\textbf{%.1f} & \\textbf{%.1f}\\\\" % (100*_grand_total_com_rate, 100*_grand_total_run_rate, 100*_grand_total_out_rate)


class LanguageStatus(LineVisitor):
	def __init__(self):
		super(LanguageStatus, self).__init__()
		self.__tasks = {}

	def visit(self, task_name, language, fuzzer_name, activity, result):
		if fuzzer_name == 'original':
			lang_dict = self.__tasks.get(task_name, data_structures.DictCount())
			lang_dict.add(language)
			self.__tasks[task_name] = lang_dict

	def export(self):
		print 'Export LanguageStatus'
		print self.langs_export
		task_stats = task_code_stats.TaskStatistics()
		loc_lang = data_structures.DictCount()

		for (tn, dcount) in self.__tasks.iteritems():
			print "%s &" % (tn,),
			__succ = 0

			for l in self.langs_export:
				if dcount.get_value(l) == 3:
					_loc = task_stats.get_loc(tn, l)
					print "%d &" % (_loc,),
					__succ += 1
					loc_lang.add(l, val=_loc)
				else:
					print "\\ding{55} &",				
			print "%d \\\\" % (__succ,)

		print " &",
		for l in self.langs_export:
			print "%d &" % (loc_lang.get_value(l),),
		print "\\\\"

def main():
	_visitors = [LanguageStatus(), AggregatedTasks()]

	fp = open('run.out', 'r')

	for l in fp:
		_t = l.split(' ')

		_task_name = _t[0].strip()
		_language = _t[1].strip()
		_fuzzer_name = _t[2].strip()
		_activity = _t[3].strip()
		_result = _t[4].strip()

		for v in _visitors:
			v.visit(_task_name, _language, _fuzzer_name, _activity, _result)

	for v in _visitors:
		v.export()


	fp.close()

if __name__ == '__main__':
	main()