Gem::Specification.new do |s|
	s.name = "rhubarbcipher"
	s.version = "0.1.0"
	s.date = "2020-06-10"
	s.summary = "A plausibly deniable multi-key encryption/decryption system for GNU/Linux and BSD."
	s.description = "RHUBARBCIPHER is a plausibly deniable multi-key file encryption/decryption system for GNU/Linux and BSD that combines one-time pad encryption/decryption with Shamir's Secret Sharing in an attempt to encrypt files in a versatile yet information-theoretically secure manner. It includes an optional decoy feature which allows users to specify a decoy file and generate a set of decoy keys in addition to the real keys. Size similarity between the decoy file and the real file is strictly enforced. WARNING: Please be aware that this gem has not undergone any form of independent security evaluation."
	s.authors = ["Peter Funnell"]
	s.email = "hello@octetsplicer.com"
	s.files = ["bin/rhubarbcipher"]
	s.executables << "rhubarbcipher"
	s.homepage = "https://github.com/octetsplicer/RHUBARBCIPHER"
	s.license = "GPL-3.0+"
	s.required_ruby_version = ">= 2.5.5"
	s.add_runtime_dependency("cloversplitter", "~> 0.2", ">= 0.2.1")
	s.requirements << "A GNU/Linux or BSD operating system."
end
