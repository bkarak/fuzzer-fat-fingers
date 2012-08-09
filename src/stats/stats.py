
class Task:
	def __init__(self, task_name):
		self.task_name = task_name
		self.fuzzers = {}
		self.fuzzer_names = []

	def update_fuzzer(fuzzer_name, language, activity, result):
		self.fuzzers.get(fuzzer_name, )


class Fuzzer:
	def __init__(self, fuzzer_name):
		self.fuzzer_name = fuzzer_name


def main():
	task_map = {}

	def parse_file(visitor_func):
		fp = open('run.out', 'r')

		for l in fp:
			visitor_func(l.strip())

		fp.close()


	def process_line(line):
		_l = line.split(' ')
		
		_task_name = _l[0].strip()
		_language = _l[1].strip()
		_fuzzer_name = _l[2].strip()
		_activity = _l[3].strip()
		_result = 

		task_obj = task_map.get(_task_name, Task(_task_name))

		task_map[_task_name] = task_obj

	# main process
	parse_file(process_line)

if __name__ == '__main__':
	main()