# Copyright [2012] [Diomidis Spinellis <dds@aueb.gr>, Vassilios Karakoidas <bkarak@aueb.gr>]
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#


class StatStructure(object):
	def __init__(self, key):
		super(StatStructure, self).__init__()
		self.key = key
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

	def rate_compiled(self, prime=0):
		return float(self.succ_compiled) / float(self.__get_succ_fuzz())

	def rate_fuzz(self, prime=0):
		return float(self.succ_fuzz) / float(self.__get_succ_fuzz())

	def rate_run(self):
		return float(self.succ_run) / float(self.__get_succ_fuzz())

	def rate_output(self):
		return float(self.fail_output) / float(self.__get_succ_fuzz())

	def __get_succ_fuzz(self):
		if self.succ_fuzz == 0:
			return 1.0

		return self.succ_fuzz

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

	def add(self, key, val=1):
		value = self.__dict.get(key, 0)
		value += val
		self.__dict[key] = value

	def get_value(self, key):
		return self.__dict.get(key, 0)

