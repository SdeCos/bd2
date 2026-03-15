# Comandos configuracion usuario git

ssh-keygen -t rsa -b 4096 -C "saul.decossanchez@alumnos.uneatlantico.es"\
eval "$(ssh-agent -s)"\
ssh-add ~/.ssh/id_rsa\
cat ~/.ssh/id_rsa.pub\
git config --global user.name SdeCos\
git config --global user.email saul.decossanchez@alumnos.uneatlantico.es\