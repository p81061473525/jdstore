class MpgController < ApplicationController
  require 'Digest'

  def form
    merchantID = 'MS17335912'
    version = '1.4'
    respondType = 'JSON'
    timeStamp = Time.now.to_i.to_s
    merchantOrderNo = "Test" + Time.now.to_i.to_s
    amt = 100
    itemDesc = "商品"
    loginType = '0'
    # Email = ''

    hashKey ='fDMeXKnd5ZZSKl7j8IUsfEm2Y1N039AW'
    hashIV ='CPgWnK21LUuiszwP'

    data = "MerchantID=#{merchantID}&RespondType=#{respondType}&TimeStamp=#{timeStamp}&Version=#{version}&MerchantOrderNo=#{merchantOrderNo}&Amt=#{amt}&ItemDesc=#{timeStamp}"
    checkValue = "HashKey=#{hashKey}&HashIV=#{hashIV}"

    data = addpadding(data)
    aes = encrypt_data(data,hashKey,hashIV,'AES-256-CBC')

    @MerchantID = merchantID
    @TradeInfo = aes
    @TradeSha = Digest::SHA256.hexdigest(checkValue).upcase
    @Version = version

    end

    private

    def addpadding(data,blocksize=32)
      len = data.length
      pad = 32 - (len % 32)
      data += pad.chr*pad
      return data
    end

    def encrypt_data(data,key,iv,cipher_type)
      cipher = OpenSSL::Cipher.new(cipher_type)
      cipher.encrypt
      cipher.key = key
      cipher.iv =iv
      encrypted = cipher.update(data)+cipher.final
      return encrypted.unpack("H*")[0].upcase
    end
end
