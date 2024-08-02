Gem::Specification.new do |s|
	s.name = "rhubarbcipher"
	s.version = "0.2.5"
	s.date = "2024-08-02"
	s.summary = "An experimental/proof-of-concept multi-key encryption/decryption system for GNU/Linux and BSD."
	s.description = "WARNING: Please be aware that this gem has not undergone any form of independent security evaluation and is provided for academic/educational purposes only. RHUBARBCIPHER should not be used to encrypt any data with high confidentiality, availability or integrity requirements, and should be treated purely as a proof of concept and/or learning exercise. RHUBARBCIPHER is an experimental multi-key file encryption/decryption system for GNU/Linux and BSD that combines one-time pad encryption/decryption with Shamir's Secret Sharing in an attempt to encrypt files in a versatile yet information-theoretically secure manner. RHUBARBCIPHER only works well on smaller files (e.g. less than 15000KiB) due to the time taken to encrypt/decrypt data, which increases as a function of file size. It includes an optional decoy feature which allows users to specify a decoy file and generate a set of decoy keys in addition to the real keys. Size similarity between the decoy file and the real file is strictly enforced."
	s.authors = ["Peter Funnell"]
	s.email = "octetsplicer@proton.me"
	s.files = ["bin/rhubarbcipher"]
	s.executables << "rhubarbcipher"
	s.homepage = "https://github.com/octetsplicer/RHUBARBCIPHER"
	s.license = "GPL-3.0+"
	s.required_ruby_version = ">= 2.5.5"
	s.add_runtime_dependency("cloversplitter", "~> 0.2", ">= 0.2.1")
	s.add_runtime_dependency("xorcist", "~> 1.1", ">= 1.1.2")
	s.requirements << "A GNU/Linux or BSD operating system."
end
