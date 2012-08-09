
class StatStructure(object):
	def __init__(self, language):
		super(StatStructure, self).__init__()
		self.language = language
		self.succ_compiled = 0
		self.fail_compiled = 0
		self.succ_run = 0
		self.fail_run = 0
		self.succ_output = 0
		self.fail_output = 0
		self.succ_fuzz = 0
		self.fail_fuzz = 0

	def update(self, activity, result):
		if activity == 'COMPILE':
			if result == 'OK':
				self.succ_compiled += 1
			else:
				self.fail_compiled += 1
		elif activity == 'FUZZ':
			if result == 'OK':
				self.succ_fuzz += 1
			else:
				self.fail_fuzz += 1
		elif activity == 'OUTPUT':
			if result == 'OK':
				self.succ_output += 1
			else:
				self.fail_output += 1
		elif activity == 'RUN':
			if result == 'OK':
				self.succ_run += 1
			else:
				self.fail_run += 1

	def rate_compiled(self):
		if self.get_total_compiled() == 0:
			return 0.0

		return float(self.succ_compiled) / float(self.get_total_compiled())

	def rate_fuzz(self):
		if self.get_total_fuzz() == 0:
			return 0.0

		return float(self.succ_fuzz) / float(self.get_total_fuzz())

	def rate_run(self):
		if self.get_total_run() == 0:
			return 0.0

		return float(self.succ_run) / float(self.get_total_run())

	def rate_output(self):
		if self.get_total_output() == 0:
			return 0.0

		return float(self.succ_output) / float(self.get_total_output())

	def get_total_compiled(self):
		return self.succ_compiled + self.fail_compiled

	def get_total_run(self):
		return self.succ_run + self.fail_run

	def get_total_output(self):
		return self.succ_output + self.fail_output

	def get_total_fuzz(self):
		return self.succ_fuzz + self.fail_fuzz

class DictCount(object):
	def __init__(self):
		super(DictCount, self).__init__()
		self.__dict = {}

	def add(self, key):
		value = self.__dict.get(key, 0)
		value += 1
		self.__dict[key] = value

	def get_value(self, key):
		return self.__dict.get(key, 0)

class LineVisitor(object):
	def __init__(self):
		super(LineVisitor, self).__init__()

	def visit(self, task_name, language, fuzzer_name, activity, result):
		pass

	def export(self):
		pass

class TaskAggregator(LineVisitor):
	def __init__(self):
		super(TaskAggregator, self).__init__()
		self.__tasks = {}
		self.__total_compiled = 0
		self.__total_run = 0
		self.__total_output = 0
		self.__total_fuz = 0

	def visit(self, task_name, language, fuzzer_name, activity, result):
		if fuzzer_name == 'prime':
			pass

		if language == 'm':
			pass

		# results are task_name, (lang, no_compiled_success, no_run_success, no_fuz, no_output_success)
		results = self.__tasks.get(task_name, {})
		stat_structure = results.get(language, StatStructure(language))
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
		self.__export(['c', 'cpp', 'cs', 'hs', 'java'])
		print "--------"
		self.__export(['js', 'php', 'pl', 'py', 'rb'])


class LanguageStatus(LineVisitor):
	def __init__(self):
		self.__tasks = {}

	def visit(self, task_name, language, fuzzer_name, activity, result):
		if fuzzer_name == 'original':
			lang_dict = self.__tasks.get(task_name, DictCount())
			lang_dict.add(language)
			self.__tasks[task_name] = lang_dict

	def export(self):
		print 'Export LanguageStatus'
		_langs = ['c', 'cpp', 'cs', 'hs', 'java', 'js', 'php', 'pl', 'py', 'rb']

		for (tn, dcount) in self.__tasks.iteritems():
			print "%s &" % (tn,),
			for l in _langs:			
				if dcount.get_value(l) == 3:
					print "\\Checkmark &",
				else:
					print "\\ding{55} &",
			print "\\\\"

def main():
	_visitors = [LanguageStatus()]

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