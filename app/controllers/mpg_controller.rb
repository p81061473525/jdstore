class MpgController < ApplicationController
  require 'digest'

  def form
 merchantID = '3430112'
 respondType = 'JSON'
 timeStamp = 1485232229
 version = '1.4'
 merchantOrderNo = 'S_1485232229'
 amt = 40
 itemDesc = "UnitTest"
 hashKey = '12345678901234567890123456789012'
 hashIV = '1234567890123456'

    merchantID = 'MS17335912' #填入你的商店號碼
    version = '1.5'
    respondType = 'JSON'
    timeStamp = Time.now.to_i.to_s
    merchantOrderNo = "Test"  + Time.now.to_i.to_s
    amt = 100
    itemDesc = "商品"
    hashKey = 'fDMeXKnd5ZZSKl7j8IUsfEm2Y1N039AW' #填入你的key
    hashIV = 'CPgWnK21LUuiszwP' #填入你的IV


      data = "MerchantID=#{merchantID}&RespondType=#{respondType}&TimeStamp=#{timeStamp}&Version=#{version}&MerchantOrderNo=#{merchantOrderNo}&Amt=#{amt}&ItemDesc=#{itemDesc}&TradeLimit=120"

      data = addpadding(data)
      aes = encrypt_data(data, hashKey, hashIV, 'AES-256-CBC')
      checkValue = "HashKey=#{hashKey}&#{aes}&HashIV=#{hashIV}"

    @merchantID = merchantID
    @tradeInfo = aes
    @tradeSha = Digest::SHA256.hexdigest(checkValue).upcase
    @version = version
  end

  private

  def addpadding(data, blocksize = 32)
    len = data.length
    pad = blocksize - ( len % blocksize)
    data += pad.chr * pad
    return data
  end

  def encrypt_data(data, key, iv, cipher_type)
    cipher = OpenSSL::Cipher.new(cipher_type)
    cipher.encrypt
    cipher.key = key
    cipher.iv = iv
    encrypted = cipher.update(data) + cipher.final
    return encrypted.unpack("H*")[0]
  end
end
