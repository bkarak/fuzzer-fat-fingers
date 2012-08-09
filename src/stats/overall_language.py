
class StatStructure:
	def __init__(self, language):
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

	def get_total_compiled(self):
		return self.succ_compiled + self.fail_compiled

	def get_total_run(self):
		return self.succ_run + self.fail_run

	def get_total_output(self):
		return self.succ_output + self.fail_output

	def get_total_fuzz(self):
		return self.succ_fuzz + self.fail_fuzz


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

		# results are task_name, (lang, no_compiled_success, no_run_success, no_fuz, no_output_success)
		results = self.__tasks.get(task_name, {})
		stat_structure = results.get(language, StatStructure(language))
		stat_structure.update(activity, result)
		results[language] = stat_structure
		self.__tasks[task_name] = results

	def export(self):
		print 'Export TaskAggregator'

		


def main():
	_visitors = [TaskAggregator()]

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