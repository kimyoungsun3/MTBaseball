<%!
	//UltraEdit 파일포맷을 변경하면 된다.
	//파일 > 변환 > (ASCII -> Unicode)
	//파일 > 변환 > (UTF-8 -> Unicode)


	public int getInt(String _str, int _idx, int _size){
		int _rtn = 0;
		int _len = _str.length();
		if(_len >= _idx + _size){
			try{
				_rtn = Integer.parseInt(_str.substring(_idx, _idx + _size));
			}catch(Exception e){
			}

		}
		return _rtn;
	}

	public int getIntFromFloat(String _str){
		int _rtn = 0;
		try{
			_rtn = (int)Float.parseFloat(_str);
		}catch(Exception e){

		}
		return _rtn;
	}
	public String getString(String _str, int _idx, int _size){
		String _rtn = "";
		int _len = _str.length();
		if(_len >= _idx + _size){
			_rtn = _str.substring(_idx, _idx + _size);
		}
		return _rtn;
	}

	public byte getByte(byte _data, int _loop){
		int _tmp = (int)_data;
		if(_tmp >= 48 && _tmp <= 57){
			_tmp -= _loop;
			if(_tmp < 48)_tmp += 10;
		}else if(_tmp >= 65 && _tmp <= 90){
			_tmp -= _loop;
			if(_tmp < 65)_tmp += 26;
		}else if(_tmp >= 97 && _tmp <= 122){
			_tmp -= _loop;
			if(_tmp < 97)_tmp += 26;
		}else{
			_tmp += _loop;
		}

		return (byte)_tmp;
	}

	public byte getByte2(byte _data, int _loop){
		int _tmp = (int)_data;
		if(_tmp >= 48 && _tmp <= 57){
			_tmp -= _loop;
			if(_tmp < 48)_tmp += 10;
		}else if(_tmp >= 65 && _tmp <= 90){
			_tmp -= _loop;
			if(_tmp < 65)_tmp += 26;
		}else if(_tmp >= 97 && _tmp <= 122){
			_tmp -= _loop;
			if(_tmp < 97)_tmp += 26;
		//}else{
		//	_tmp += _loop;
		}

		return (byte)_tmp;
	}

	public String getDencode2(String _str, int _checkLen){
		int _len, _len2;
		int _loop, _size;
		byte _sum, _sum2;
		byte[] gsbByte;

		_len = _str.length();
		if(_len >= _checkLen){
			_loop = getInt(_str, 0, 1);
			_sum = (byte)getInt(_str, _len - 3, 3);
			_str = getString(_str, 1, _len - (1+3));
			gsbByte = _str.getBytes();
			_len2 = gsbByte.length;
			_sum2 = 0;
			for(int i = 0; i < _len2; i++){
				gsbByte[i] = getByte(gsbByte[i], _loop);
				_sum2 += gsbByte[i];
			}

			_str = new String(gsbByte);
			_size = getInt(_str, 0, 3);

			if(_sum != _sum2){
				//조작을 했구나!!!
				_str = "-2";
			}else{
				_str = getString(_str, 3, _size);
			}

			//out.print(" _len:" + _len);
			//out.print(" _loop:" + _loop);
			//out.print(" _size:" + _size);
			//out.print(" _sum:" + _sum);
			//out.print(" _sum2:" + _sum2);
			//out.print(" _str:" + _str);
			//out.print(" gmode:" + gmode);
		}
		return _str;
	}

	public String getDencode32(int _crypt, String _str, String _strInit){
		int _len, _len2;
		int _loop, _size;
		byte _sum, _sum2;
		byte[] gsbByte;

		_len = _str.length();
		if(_crypt == 1){
			_loop = getInt(_str, 0, 1);
			_sum = (byte)getInt(_str, _len - 3, 3);
			_str = getString(_str, 1, _len - (1+3));
			gsbByte = _str.getBytes();
			_len2 = gsbByte.length;
			_sum2 = 0;
			for(int i = 0; i < _len2; i++){
				gsbByte[i] = getByte2(gsbByte[i], _loop);
				_sum2 += gsbByte[i];
			}

			_str = new String(gsbByte);
			_size = getInt(_str, 0, 3);
			if(_size <= 0){
				_str = "";
			}else{
				_str = getString(_str, 3, _size);
			}

			if(_sum != _sum2){
				//조작을 했구나!!!
				_str = _strInit;
			}
			//_str = "_loop:" + _loop
			//		+ " _size:" + _size
			//		+ " _str:[" + _str + "]"
			//		+ " _len2:" + _len2
			//		+ " _sum2:" + _sum2
			//		+ " _sum:" + _sum;
		}
		return _str;
	}

	public String getDencode4(String _str, int _checkLen, String _strInit){
		int _len, _len2;
		int _loop, _size;
		byte _sum, _sum2;
		byte[] gsbByte;

		_len = _str.length();
		if(_len >= _checkLen){
			_loop = getInt(_str, 0, 1);
			_sum = (byte)getInt(_str, _len - 3, 3);
			_str = getString(_str, 1, _len - (1+3));
			gsbByte = _str.getBytes();
			_len2 = gsbByte.length;
			_sum2 = 0;
			for(int i = 0; i < _len2; i++){
				gsbByte[i] = getByte(gsbByte[i], _loop);
				_sum2 += gsbByte[i];
			}

			_str = new String(gsbByte);
			_str = _str.substring(0, _str.length() - 14);
			_size = getInt(_str, 0, 3);

			if(_sum != _sum2){
				//조작을 했구나!!!
				_str = _strInit;
			}else{
				_str = getString(_str, 3, _size);
			}
		}
		return _str;
	}

	public String getDencode5(String _str, int _checkLen, String _strInit){
		int _len, _len2;
		int _loop, _size;
		byte _sum, _sum2;
		byte[] gsbByte;

		_len = _str.length();
		if(_len >= _checkLen){
			_loop = getInt(_str, 0, 1);
			_sum = (byte)getInt(_str, _len - 4, 4);
			_str = getString(_str, 1, _len - (1+4));
			gsbByte = _str.getBytes();
			_len2 = gsbByte.length;
			_sum2 = 0;
			for(int i = 0; i < _len2; i++){
				gsbByte[i] = getByte(gsbByte[i], _loop);
				_sum2 += gsbByte[i];
			}

			_str = new String(gsbByte);
			_str = _str.substring(0, _str.length() - 14);
			_size = getInt(_str, 0, 4);

			if(_sum != _sum2){
				//조작을 했구나!!!
				_str = _strInit;
			}else{
				_str = getString(_str, 4, _size);
			}
		}
		return _str;
	}


	public String getDencode6(String _str, int _checkLen, String _strInit){
		int _len, _len2;
		int _loop, _loop1, _loop2, _size;
		int _key, _key2, _key3;
		byte _sum, _sum2;
		byte[] gsbByte;
		_len = _str.length();

		if(_len >= _checkLen){
			_loop1 = getInt(_str, 0, 1);
			_loop2 = getInt(_str, 1, 1);
			_key3 = getInt(_str, _len - 4, 4)/3;
			_sum = (byte)getInt(_str, _len - 8, 4);
			_str = getString(_str, 4, _len - (4+4+4));
			gsbByte = _str.getBytes();
			_len2 = gsbByte.length;
			_sum2 = 0;
			for(int i = 0; i < _len2; i++){
				_loop = i%2==0?_loop1:_loop2;

				gsbByte[i] = getByte(gsbByte[i], _loop);
				_sum2 += gsbByte[i];
			}

			_str = new String(gsbByte);
			_str = _str.substring(0, _str.length() - 14);
			_size = getInt(_str, 0, 4);
			_key = getInt(_str, 4, 4);
			_key2 = getInt(_str, _str.length() - 4, 4)/2;

			if(_sum != _sum2 || _key != _key2 || _key != _key3){
				//조작을 했구나!!!
				_str = _strInit;
			}else{
				_str = getString(_str, 8, _size);
			}
		}
		return _str;
	}

%>

