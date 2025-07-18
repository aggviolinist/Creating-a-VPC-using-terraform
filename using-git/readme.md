## Removing a committed file on github from github
```sh
pip install git-filter-repo
cd ..
cd Creating-a-VPC-using-terraform/
git remote -v
cd ..
git clone https://github.com/aggviolinist/Creating-a-VPC-using-terraform.git clean-cp
cd clean-cp/
git remote -v
git-filter-repo --sensitive-data-removal --invert-paths --path variable.tf
git push --force --all  origin
git pull
git add .
git commit -m "removing variable files"
git push
```