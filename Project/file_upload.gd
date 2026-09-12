extends Button

# I try to use AI as little as possible. unfortunately, I didn't want to spend 10 hours learning all
# the different types of wav files and how to check them. 95% of the code below is AI. I wish it
# wasn't, but its what I had to do to finish this project.
func _process(_delta: float) -> void:
	if GlobalVariable.page == 0:
		self.visible = true
	else:
		self.visible = false

func _on_pressed() -> void:
	$"../FileDialog".popup()


func _on_file_dialog_file_selected(path: String) -> void:
	var stream := load_audio(path)

	if stream == null:
		GlobalVariable.filetext = "Invalid File"
		GlobalVariable.justopened = true
		return

	if stream:
		$"../NormalAudio".stream = stream
		$"../DualAudio".stream = stream
		GlobalVariable.justopened = true
		GlobalVariable.filetext = path.get_file()


func load_audio(path: String) -> AudioStream:
	var ext := path.get_extension().to_lower()

	match ext:
		"wav":
			if is_wav_file(path):
				return load_wav(path)

		"mp3":
			return AudioStreamMP3.load_from_file(path)

	return null


func is_wav_file(path: String) -> bool:
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		return false

	if file.get_length() < 12:
		return false

	var riff := file.get_buffer(4).get_string_from_ascii()
	file.get_32() # Skip file size
	var wave := file.get_buffer(4).get_string_from_ascii()

	return riff == "RIFF" and wave == "WAVE"


func load_wav(path: String) -> AudioStreamWAV:
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		push_error("Couldn't open file: " + path)
		return null

	# RIFF
	if file.get_buffer(4).get_string_from_ascii() != "RIFF":
		push_error("Not a RIFF file.")
		return null

	file.get_32() # File size

	# WAVE
	if file.get_buffer(4).get_string_from_ascii() != "WAVE":
		push_error("Not a WAVE file.")
		return null

	var channels := 1
	var sample_rate := 44100
	var bits_per_sample := 16
	var pcm_data := PackedByteArray()

	while file.get_position() < file.get_length():
		var chunk_id := file.get_buffer(4).get_string_from_ascii()
		var chunk_size := file.get_32()

		match chunk_id:
			"fmt ":
				var audio_format = file.get_16()
				channels = file.get_16()
				sample_rate = file.get_32()
				file.get_32() # byte rate
				file.get_16() # block align
				bits_per_sample = file.get_16()

				if audio_format != 1:
					push_error("Only PCM WAV files are supported.")
					return null

				# Skip any extra fmt bytes
				if chunk_size > 16:
					file.seek(file.get_position() + (chunk_size - 16))

			"data":
				pcm_data = file.get_buffer(chunk_size)
				break

			_:
				# Skip unknown chunks
				file.seek(file.get_position() + chunk_size)

	var stream := AudioStreamWAV.new()
	stream.data = pcm_data
	stream.mix_rate = sample_rate
	stream.stereo = channels == 2

	match bits_per_sample:
		8:
			stream.format = AudioStreamWAV.FORMAT_8_BITS
		16:
			stream.format = AudioStreamWAV.FORMAT_16_BITS
		_:
			push_error("Unsupported bit depth: %d" % bits_per_sample)
			return null

	return stream
