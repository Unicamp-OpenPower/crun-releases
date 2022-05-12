import requests
# find and save the current Github release
html = str(
    requests.get('https://github.com/containers/crun/releases/latest')
    .content)
index = html.find('Release ')
github_version = html[index + 8:index + 13]
file = open('github_version.txt', 'w')
file.writelines(github_version)
file.close()

# find and save the current Bazel version on FTP server
html = str(
    requests.get(
        'https://oplab9.parqtec.unicamp.br/pub/ppc64el/crun/latest'
    ).content)
index = html.rfind('crun-')
ftp_version = html[index + 5:index + 10]
file = open('ftp_version.txt', 'w')
file.writelines(ftp_version)
file.close()

# find and save the oldest Bazel version on FTP server
html = str(
    requests.get(
        'https://oplab9.parqtec.unicamp.br/pub/ppc64el/crun'
    ).content)
index = html.find('crun-')
delete = html[index + 5:index + 9]
file = open('delete_version.txt', 'w')
file.writelines(delete)
file.close()
