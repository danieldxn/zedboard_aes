library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.aes_package.all;

entity lastState is
	port (inState : in  STATE;
			mode  : in AES_MODE;
			inKey : in  STATE;
			outState : out STATE
			);
			
end lastState;

architecture Behavioral of lastState is
	signal temp_encrypt : STATE_ARRAY (0 to 2);
	signal temp_decrypt : STATE_ARRAY (0 to 2);

begin
		subBytes   : entity work.subBytes    port map (inMode => ENCRYPTION, inState => inState, outState => temp_encrypt (0));
		shiftRows  : entity work.shiftRows   port map (inMode => ENCRYPTION, inState => temp_encrypt (0), outState => temp_encrypt (1));
		addRoundKey: entity work.addRoundKey port map (inState => temp_encrypt (1), inKey => inKey, outState => temp_encrypt (2)); 
	

		invShiftRows : entity work.shiftRows port map (inMode => DECRYPTION, inState => inState, outState => temp_decrypt (0));
		invSubBytes  : entity work.subBytes  port map (inMode => DECRYPTION, inState => temp_decrypt (0), outState => temp_decrypt (1));
		invAddRoundKey  : entity work.addRoundKey  port map (inState => temp_decrypt (1), inKey => inKey, outState => temp_decrypt (2));
		
		outState <= temp_encrypt (2) when (mode = ENCRYPTION) else temp_decrypt (2);	
 
end Behavioral;

