import numpy as np
from scipy import signal as sig
from scipy import optimize as opt


class TF_identificator:
    def __init__(self):
        self.tf = None
        self.inputs = None

    def first_order_mdl(self, t, k, pole):
        self.tf = sig.TransferFunction(k, [pole, 1])
        to, yo, xo = sig.lsim2(self.tf, U=self.inputs, T=t)
        return yo

    def second_order_mdl(self, t, k, wn, delta):
        self.tf = sig.TransferFunction(k*(wn**2), [1, 2*delta*wn, wn**2])
        to, yo, xo = sig.lsim2(self.tf, U=self.inputs, T=t)
        return yo

    def identify_first_order(self, t, u, orig_output, method='lm', p0=[1.0, 1.0]):
        self.inputs = u
        params, params_cov = opt.curve_fit(self.first_order_mdl, t, orig_output,
                                           method=method, maxfev=100, p0=p0)
        return {'k': params[0], 'tau': params[1]}

    def identify_second_order(self, t, u, orig_output, method='lm', p0=[1.0, 1.0, 0.1]):
        self.inputs = u
        params, params_cov = opt.curve_fit(self.second_order_mdl, t, orig_output,
                                           method=method, maxfev=100, p0=p0)
        return {'k': params[0], 'wn': params[1], 'zeta': params[2]}