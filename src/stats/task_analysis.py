from overall_language import LineVisitor
from data_structures import DictListCount


class TaskAnalyzer(LineVisitor):
	def __init__(self):
		super(TaskAnalyzer, self).__init__()
		self.fuzzers = ['FuzzIntegerPerturbation', 
						'FuzzIdentifierSubstitution', 
						'FuzzSimilarSubstitution', 
						'FuzzRandomCharacterSubstitution', 
						'FuzzRandomTokenSubstitution']
		self.activities = ['COMPILE', 'FUZZ', 'RUN', 'OUTPUT']
		self.languages = ['c', 'cpp', 'cs', 'hs', 'java', 'js', 'php', 'pl', 'py', 'rb']
		self.results = DictListCount(2)



	def visit(self, task_name, language, fuzzer_name, activity, result):
		if fuzzer_name == 'prime' or fuzzer_name == 'original':
			return

		key = '%s-%s-%s' % (fuzzer_name, language, activity)

		if result == 'OK':
			self.results.add(key, 0, val=1)
		elif result == 'FAIL':
			self.results.add(key, 1, val=1)

	def export(self):
		for fuz in self.fuzzers:
			for act in self.activities:
				fp = open('analytics/%s-%s.text' % (fuz, act), 'w')

				for lang in self.languages:
					key = '%s-%s-%s' % (fuz, lang, act)
					counters = self.results.get_value(key)
					fp.write('%s %d %d\n' % (lang, counters[0], counters[1]))
				
				fp.close()