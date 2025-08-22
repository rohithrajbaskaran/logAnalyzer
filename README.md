# 📊 Bash Log Analyzer

A lightweight **log analysis tool** written in pure **Bash**.  
It parses **Apache/Nginx access logs** (or any logs in the standard combined format) and provides quick insights such as traffic stats, top IPs, most requested URLs, error analysis, and more.  

---

## ✨ Features
- 📈 **Total requests** and **unique visitors**  
- 🌍 **Top IP addresses**  
- 📂 **Top requested URLs**  
- 🔢 **HTTP status code distribution**  
- 🚫 **404 error breakdown**  
- ⏰ **Requests per hour** (traffic timeline)  
- 💻 **Top user agents** (browsers, bots, crawlers)  
- 🎨 **Colored output** and **ASCII bar charts** for visualization  
- 🧑‍💻 **Interactive menu** for easy navigation  

---

## 📦 Requirements
- macOS / Linux  
- Standard shell utilities: `awk`, `sort`, `uniq`, `head`, `tput`  
- Access log file in **Apache/Nginx combined log format**  


---

## ⚙️ Installation
Clone this repo or download the script:

```bash
git clone https://github.com/rohithrajbaskaran/logAnalyzer.git
cd logAnalyzer
chmod +x loganalyzer.sh
```

---

## 🚀 Usage
```./loganalyzer.sh /path/to/access.log```

Add the path to your apache/nginx access logs.

---

## 📊 Sample Output

=== Top 10 IPs ===

192.168.1.5: ####### (70) <br>
10.0.0.2: #### (40) <br>
203.0.113.9: ### (30) <br>

