package mall.common.digest;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class DigestUtils {
    
    /** ARIA KEY */
    @Value("#{config['aria.key']}") 
    public String ARIA_KEY;

    /**
     * KISA SHA256 암호화
     * 
     * @param data
     * @return
     */
    public String kisaSha256(String data) {
        
        byte[] pbData = data.getBytes();
        byte[] pbCipher = new byte[32];
        
        KISA_SHA256.SHA256_Encrpyt(pbData, pbData.length, pbCipher );
        
        StringBuffer encryptedText = new StringBuffer();
        for (int i=0; i < 32; i++) {
            encryptedText.append(Integer.toHexString(0xff&pbCipher[i]));
        }
        
        return encryptedText.toString();
    }
    
    /**
     * ARIA 암호화
     * 
     * @param data
     * @return
     */
    public String ariaEncrpyt(String data) {
        
        String encryptedText = "";
        
        try {
            ARIAProvider aria = new ARIAProvider(256);
            aria.createMasterKey(ARIA_KEY);
            encryptedText = aria.encryptToString(data);
        } catch (Exception e) {

        }
        
        return encryptedText;
        
    }
    
    /**
     * ARIA 복호화
     * 
     * @param data
     * @return
     */
    public String ariaDecrypt(String data) {
        
        String decryptedText = "";
        
        try {
            ARIAProvider aria = new ARIAProvider(256);
            aria.createMasterKey(ARIA_KEY);
            decryptedText = aria.decryptFromString(data);
        } catch (Exception e) {
            
        }

        return decryptedText;
        
    }

}
