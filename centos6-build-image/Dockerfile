FROM centos:6

ENV PATH /root/.cargo/bin:/opt/centos/devtoolset-1.0/root/usr/bin/:$PATH
ENV RUST_BACKTRACE 1

# Install prerequisites
RUN yum -y install kernel-headers openssl-devel

# Install glibc 2.17
RUN curl http://copr-be.cloud.fedoraproject.org/results/mosquito/myrepo-el6/epel-6-x86_64/glibc-2.17-55.fc20/glibc-2.17-55.el6.x86_64.rpm -o glibc-2.17-55.el6.x86_64.rpm
RUN curl http://copr-be.cloud.fedoraproject.org/results/mosquito/myrepo-el6/epel-6-x86_64/glibc-2.17-55.fc20/glibc-common-2.17-55.el6.x86_64.rpm -o glibc-common-2.17-55.el6.x86_64.rpm
RUN curl http://copr-be.cloud.fedoraproject.org/results/mosquito/myrepo-el6/epel-6-x86_64/glibc-2.17-55.fc20/glibc-devel-2.17-55.el6.x86_64.rpm -o glibc-devel-2.17-55.el6.x86_64.rpm
RUN curl http://copr-be.cloud.fedoraproject.org/results/mosquito/myrepo-el6/epel-6-x86_64/glibc-2.17-55.fc20/glibc-headers-2.17-55.el6.x86_64.rpm -o glibc-headers-2.17-55.el6.x86_64.rpm

RUN rpm -Uvh glibc-2.17-55.el6.x86_64.rpm \
    glibc-common-2.17-55.el6.x86_64.rpm \
    glibc-devel-2.17-55.el6.x86_64.rpm \
    glibc-headers-2.17-55.el6.x86_64.rpm

# Custom install gcc 4.7+
RUN curl https://people.centos.org/tru/devtools-1.1/devtools-1.1.repo -o /etc/yum.repos.d/devtools-1.1.repo
RUN yum -y --enablerepo=testing-1.1-devtools-6 install devtoolset-1.1-gcc devtoolset-1.1-gcc-c++

# Install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y