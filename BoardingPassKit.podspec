Pod::Spec.new do |s|
	s.name         = "BoardingPassKit"
	s.version      = "0.3.0"
	s.summary      = "A library to parse the contents of airline boarding pass barcodes."
	s.description  = <<-DESC
		BoardingPassKit allows parsing the content of airline boarding pass barcodes.
		Use other means to parse the actual PDF417, Aztec, or QR Code and then pass the result to
		BPKBoardingPass(data:).
	DESC

	s.homepage     = "https://github.com/invliD/BoardingPassKit"
	s.license      = "MPL-2.0"
	s.author       = "Sebastian Brückner"

	s.ios.deployment_target = "12.0"
	# s.osx.deployment_target = "10.7"
	# s.watchos.deployment_target = "2.0"
	# s.tvos.deployment_target = "9.0"

	s.swift_version = '5.0'
	s.source       = { :git => "https://github.com/invliD/BoardingPassKit.git", :tag => "#{s.version}" }
	s.source_files = "Sources/**/*.swift"
	s.requires_arc = true
end
