# Necdet Projesi

## Claude Code Talimatları

### Genel Kurallar
- Markdown formatını kullan
- **Commit mesajları Türkçe ve açıklamalı yazılmalıdır**
- Commit mesajlarına "Co-Authored-By" veya benzeri AI imza satırları **EKLENMEMELİDİR**

### Türkçe Karakter Kullanımı
- **Türkçe içeriklerde (e-posta, belge, rapor) mutlaka Türkçe karakterler (ç, ğ, ı, ö, ş, ü, İ) kullanılmalıdır**
- Yanlış: "Merhaba Yigit, gonderilmektedir" → Doğru: "Merhaba Yiğit, gönderilmektedir"

### Commit Mesaj Formatı
```
<tip>: <kısa açıklama>

<detaylı açıklama - ne yapıldı, neden yapıldı>
```

## Dosya Organizasyonu

| Klasör | Kullanım |
|--------|----------|
| `output/` | Geçici çıktılar (raporlar, dönüştürülmüş belgeler) |
| `assets/` | Kalıcı dosyalar - silinmemeli |

## Kabuk Araçları

| İşlem | Araç | Örnek |
|-------|------|-------|
| Dosya bulmak | `fd` | `fd "*.pdf" skills/` |
| Metin aramak | `rg` | `rg "import" --type py` |
| JSON işlemek | `jq` | `jq '.key' data.json` |
